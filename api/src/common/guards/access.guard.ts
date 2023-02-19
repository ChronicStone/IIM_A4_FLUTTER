import { AuthService } from '@modules/auth/auth.service';
import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

/**
 * Access guard for Nest authentication mechanism
 */
@Injectable()
export class AccessGuard implements CanActivate {
  constructor(private readonly authService: AuthService) {}

  /**
   * Check if this method can be activated with given execution context
   * @param context
   */
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const authToken = context.switchToHttp().getRequest().headers.authorization;
    const user = await this.authService.validateAccessToken(
      authToken.split(' ')[1],
    );

    context.switchToHttp().getRequest().user = user;
    return true;
  }
}
