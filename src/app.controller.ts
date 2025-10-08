import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('/list')
  listOfProducts() {
    return [{ id: 1, title: 'product 1', description: 'my product' }];
  }

  @Get('/list/name')
  listOfNames() {
    
    
    return this.appService.getNewNames()

    


  }

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
