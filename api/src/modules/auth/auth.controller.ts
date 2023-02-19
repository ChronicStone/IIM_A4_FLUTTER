import { CreateUserDto } from './dto/create-user.dto';
import { AuthDto } from './dto/auth.dto';
import { AuthService } from './auth.service';
import {
  Body,
  Controller,
  Logger,
  Post,
  Req,
  UseGuards,
  ValidationPipe,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { RequestWithUser } from './dto/request-with-account.interface';
import { AccessTokenResponse } from '@common/types/user';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  @UseGuards(AuthGuard('local'))
  async login(
    @Req() { user }: RequestWithUser,
    @Body() {}: AuthDto,
  ): Promise<AccessTokenResponse> {
    return this.authService.login(user);
  }

  @Post('register')
  async register(
    @Body(new ValidationPipe({ transform: true })) userData: CreateUserDto,
  ) {
    Logger.debug(JSON.stringify(userData, null, 4));
    return this.authService.registerUser(userData);
  }

  @Post('check-email-available')
  async validateEmail(@Body('email') email: string) {
    return this.authService.verifyEmailAvailable(email);
  }
}
