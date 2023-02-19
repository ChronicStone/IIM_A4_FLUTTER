import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { hashPassword } from '@shared/utils/hash-password';
import { Transform } from 'class-transformer';
import mongoose, { Document } from 'mongoose';

export type UserDocument = User & Document;

@Schema({ timestamps: true, toJSON: { virtuals: true } })
export class User {
  @Transform(({ value }) => value.toString())
  _id: mongoose.Types.ObjectId;

  @Prop()
  firstName: string;

  @Prop()
  lastName: string;

  @Prop()
  email: string;

  @Prop({ select: false })
  password: string;
}

const UserSchema = SchemaFactory.createForClass(User);

UserSchema.pre('save', function (next) {
  if (this.isModified('password') && this.password)
    this.password = hashPassword(this.password);

  next();
});

export { UserSchema };
