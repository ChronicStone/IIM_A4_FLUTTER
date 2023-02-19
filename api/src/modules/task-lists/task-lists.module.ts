import { AuthModule } from './../auth/auth.module';
import { TaskUpdateSchema, TaskUpdate } from '@schemas/task-update.schema';
import { Task, TaskSchema } from '@schemas/task.schema';
import { Module } from '@nestjs/common';
import { TaskListsService } from './task-lists.service';
import { TaskListsController } from './task-lists.controller';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Task.name, schema: TaskSchema },
      { name: TaskUpdate.name, schema: TaskUpdateSchema },
    ]),
    AuthModule,
  ],
  providers: [TaskListsService],
  controllers: [TaskListsController],
})
export class TaskListsModule {}
