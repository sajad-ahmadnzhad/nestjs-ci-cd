import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const logger = new Logger('NestApplication');

  await app.listen(process.env.PORT ?? 3000);

  if (process.env.NODE_ENV !== 'production') {
    logger.log(`server ready on production url: ${await app.getUrl()}`);
  } else logger.log(`server ready on development url: ${await app.getUrl()}`);
}
bootstrap();
