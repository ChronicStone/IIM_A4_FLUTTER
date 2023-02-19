import { User } from '@schemas/user.schema';

export class AccessTokenResponse {
  accessToken: string;
  account: Omit<User, 'password' | '_id'> & { id: string };
}
