import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './modules/auth/auth.module';
import { TaskListsModule } from './modules/task-lists/task-lists.module';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule, ConfigService } from '@nestjs/config';
import appConfig from '@config/app.config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [appConfig],
    }),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        uri: configService.get<string>('app.database.url'),
        useNewUrlParser: true,
      }),
      inject: [ConfigService],
    }),
    AuthModule,
    TaskListsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
