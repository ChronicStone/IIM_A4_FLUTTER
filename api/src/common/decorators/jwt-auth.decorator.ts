import { applyDecorators, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AccessGuard } from '@common/guards/access.guard';

export function JWTAuth() {
  return applyDecorators(UseGuards(AuthGuard('jwt'), AccessGuard));
}
