import { Task } from './task.schema';
import { User } from '@schemas/user.schema';
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Transform } from 'class-transformer';
import mongoose from 'mongoose';

export type TaskUpdateDocument = TaskUpdate & Document;

@Schema({ timestamps: true, toJSON: { virtuals: true } })
export class TaskUpdate {
  @Transform(({ value }) => value.toString())
  _id: mongoose.Types.ObjectId;

  @Prop()
  content: string;

  @Prop()
  progress: number;

  @Prop({ type: mongoose.Types.ObjectId, ref: 'Task' })
  task: Task;
}

export const TaskUpdateSchema = SchemaFactory.createForClass(TaskUpdate);
