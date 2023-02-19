import {
  BadRequestException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { JwtService } from '@nestjs/jwt';
import { compare } from 'bcrypt';
import { User, UserDocument } from '@schemas/user.schema';
import { Model } from 'mongoose';
import { CreateUserDto } from './dto/create-user.dto';
import { AuthDto } from './dto/auth.dto';
import { AccessTokenResponse } from '@common/types/user';

@Injectable()
export class AuthService {
  constructor(
    private readonly jwtService: JwtService,
    @InjectModel(User.name) private readonly userModel: Model<UserDocument>,
  ) {}

  async registerUser(userData: CreateUserDto) {
    const credentialsExist = await this.userModel.findOne({
      email: userData.email,
    });

    if (credentialsExist) throw new BadRequestException('User already exists');

    return this.userModel.create({
      firstName: userData.firstName,
      lastName: userData.lastName,
      email: userData.email,
      password: userData.password,
    });
  }

  async validate(payload: AuthDto): Promise<UserDocument> {
    const account = await this.findUserByEmailWithSecret(payload.email);

    if (account && (await compare(payload.password, account.password)))
      return account;

    return null;
  }

  async validateAccessToken(token: string, throwOnErr = true): Promise<User> {
    try {
      Logger.debug(`Validating access token ${token}`);
      const payload = throwOnErr
        ? await this.jwtService.verifyAsync(token)
        : this.jwtService.decode(token);
      return await this.userModel.findOne({ _id: payload?._id ?? null });
    } catch (error) {
      Logger.error(error);
      return null;
    }
  }

  async login(user: UserDocument): Promise<AccessTokenResponse> {
    if (!user) throw new NotFoundException();

    return {
      account: this.getActiveAccountInfo(user),
      accessToken: await this.generateAccessToken(user),
    };
  }

  findUserByEmailWithSecret(email: string) {
    return this.userModel
      .findOne({
        email: {
          $regex: this.escapeRegExp(email),
          $options: 'i',
        },
      })
      .populate(['password']);
  }

  async generateAccessToken(account: UserDocument): Promise<string> {
    return this.jwtService.sign(account.toObject(), {
      expiresIn: '30d',
    });
  }

  protected getActiveAccountInfo(user: UserDocument) {
    const { _id, firstName, lastName, email } = user;
    return {
      id: _id,
      firstName,
      lastName,
      email,
    };
  }

  private escapeRegExp(string) {
    return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }

  async verifyEmailAvailable(email: string) {
    return !!(await this.userModel.count({ email }));
  }
}
