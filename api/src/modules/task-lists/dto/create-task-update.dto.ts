import { IsNumber, IsString, Max, Min } from 'class-validator';

export class CreateTaskUpdate {
  @IsString()
  content: string;

  @IsNumber()
  @Min(0)
  @Max(100)
  progress: number;
}
