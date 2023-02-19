import { TaskUpdate, TaskUpdateDocument } from '@schemas/task-update.schema';
import { Task, TaskDocument } from '@schemas/task.schema';
import { InjectModel } from '@nestjs/mongoose';
import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import { Model } from 'mongoose';
import { CreateTaskDto } from './dto/create-task.dto';
import { User } from '@schemas/user.schema';
import { CreateTaskUpdate } from './dto/create-task-update.dto';

@Injectable()
export class TaskListsService {
  constructor(
    @InjectModel(Task.name) private readonly taskModel: Model<TaskDocument>,
    @InjectModel(TaskUpdate.name)
    private readonly taskUpdateModel: Model<TaskUpdateDocument>,
  ) {}

  getUserTasks(user: User) {
    return this.taskModel.find({ user: user._id }).populate('updates');
  }

  createTask(taskData: CreateTaskDto, user: User) {
    return this.taskModel.create({
      title: taskData.title,
      description: taskData.description,
      tags: taskData?.tags ?? [],
      user: user._id,
    });
  }

  async createTaskUpdate(
    taskId: string,
    updateData: CreateTaskUpdate,
    user: User,
  ) {
    const task = await this.taskModel.findOne({ _id: taskId, user: user._id });
    if (!task) throw new BadRequestException('Task not found');

    Logger.debug(`POSTING UPDATE ON TASK ${taskId}`);
    Logger.debug(JSON.stringify(updateData, null, 2));

    task.progress = updateData.progress;
    await task.save();

    return this.taskUpdateModel.create({
      task: task._id,
      content: updateData.content,
      progress: updateData.progress,
    });
  }
}
