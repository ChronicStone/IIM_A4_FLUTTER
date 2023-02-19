import { CreateTaskUpdate } from './dto/create-task-update.dto';
import { CreateTaskDto } from './dto/create-task.dto';
import { User } from '@schemas/user.schema';
import { ActiveUser } from '@common/decorators/user.decorator';
import { JWTAuth } from '@common/decorators/jwt-auth.decorator';
import { TaskListsService } from './task-lists.service';
import {
  Body,
  Controller,
  Get,
  Logger,
  Param,
  Post,
  ValidationPipe,
} from '@nestjs/common';

@Controller('tasks')
export class TaskListsController {
  constructor(private readonly taskService: TaskListsService) {}

  @Get('')
  @JWTAuth()
  getUserTasks(@ActiveUser() user: User) {
    Logger.debug('RESOLVING USER TASKS');
    return this.taskService.getUserTasks(user);
  }

  @Post()
  @JWTAuth()
  createTask(
    @Body(new ValidationPipe({ transform: true })) taskData: CreateTaskDto,
    @ActiveUser() user: User,
  ) {
    Logger.debug(JSON.stringify(taskData, null, 2));
    return this.taskService.createTask(taskData, user);
  }

  @Post(':taskId')
  @JWTAuth()
  createTaskUpdate(
    @Param('taskId') taskId: string,
    @Body(new ValidationPipe({ transform: true })) updateData: CreateTaskUpdate,
    @ActiveUser() user: User,
  ) {
    return this.taskService.createTaskUpdate(taskId, updateData, user);
  }
}
