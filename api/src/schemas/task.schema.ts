import { User } from '@schemas/user.schema';
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Transform } from 'class-transformer';
import mongoose from 'mongoose';
import { TaskUpdate } from './task-update.schema';

export type TaskDocument = Task & Document;

@Schema({ timestamps: true, toJSON: { virtuals: true } })
export class Task {
  @Transform(({ value }) => value.toString())
  _id: mongoose.Types.ObjectId;

  @Prop()
  title: string;

  @Prop()
  description?: string;

  @Prop()
  tags: string[];

  @Prop({ default: 0 })
  progress: number;

  @Prop({ type: mongoose.Types.ObjectId, ref: User.name })
  user: User;

  updates: TaskUpdate[];
}

const TaskSchema = SchemaFactory.createForClass(Task);

TaskSchema.virtual('updates', {
  ref: 'TaskUpdate',
  localField: '_id',
  foreignField: 'task',
});

export { TaskSchema };
