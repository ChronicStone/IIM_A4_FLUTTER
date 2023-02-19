import { PassportStrategy } from '@nestjs/passport';
import {
  BadRequestException,
  Injectable,
  Logger,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthService } from '../auth.service';
import { Strategy } from 'passport-custom';
import { User } from '@schemas/user.schema';
import { Request } from 'express';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy, 'local') {
  constructor(private authService: AuthService) {
    super();
  }

  async validate(request: Request): Promise<User> {
    const { email, password } = request.body;

    Logger.debug({ email, password });
    const user = await this.authService.validate({ email, password });

    if (!user) {
      throw new UnauthorizedException(
        'Username, password or provider validation failed',
      );
    }
    return user;
  }
}
