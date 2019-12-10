#define switch1 (volatile char *) 0x0002040
#define rst (volatile char *) 0x0002030
#define display1 (char *) 0x0002020
#define display2 (char *) 0x0002010
#define display3 (char *) 0x0002000

void main(){
	int number, num0, num1, num2 = 0;

	while(1){
        // FALTANDO TRATAR O RESET

        while(*switch1 == 0x00){
        	if(*rst == 0x01) number = 0;
        }

		if((*switch1 & 0x03) == 0x01) number = number + 10;
		else if((*switch1 & 0x03) == 0x02) number = number + 25;
        else if((*switch1 & 0x03) == 0x02) number = number + 50;

        if(((*switch1 & 0x04) & number >= 80) == 0x01) number = number - 80;

		num0 = number % 10;
		num1 = (number / 10) % 10;
		num2 = number / 100;

		switch(num0){
		case 0:
			*display1 = 0x40;
			break;
		case 1:
			*display1 = 0x79;
			break;
		case 2:
			*display1 = 0x24;
			break;
		case 3:
			*display1 = 0x30;
			break;
		case 4:
			*display1 = 0x19;
			break;
		case 5:
			*display1 = 0x12;
			break;
		case 6:
			*display1 = 0x02;
			break;
		case 7:
			*display1 = 0x78;
			break;
		case 8:
			*display1 = 0x00;
			break;
		case 9:
			*display1 = 0x10;
			break;
		default:
			*display1 = 0x7F;
			break;
	}

	switch(num1){
		case 0:
			*display2 = 0x40;
			break;
		case 1:
			*display2 = 0x79;
			break;
		case 2:
			*display2 = 0x24;
			break;
		case 3:
			*display2 = 0x30;
			break;
		case 4:
			*display2 = 0x19;
			break;
		case 5:
			*display2 = 0x12;
			break;
		case 6:
			*display2 = 0x02;
			break;
		case 7:
			*display2 = 0x78;
			break;
		case 8:
			*display2 = 0x00;
			break;
		case 9:
			*display2 = 0x10;
			break;
		default:
			*display2 = 0x7F;
			break;
	}
	switch(num2){
    		case 0:
    			*display3 = 0x40;
    			break;
    		case 1:
    			*display2 = 0x79;
    			break;
    		case 2:
    			*display3 = 0x24;
    			break;
    		case 3:
    			*display3 = 0x30;
    			break;
    		case 4:
    			*display3 = 0x19;
    			break;
    		case 5:
    			*display3 = 0x12;
    			break;
    		case 6:
    			*display3 = 0x02;
    			break;
    		case 7:
    			*display3 = 0x78;
    			break;
    		case 8:
    			*display3 = 0x00;
    			break;
    		case 9:
    			*display3 = 0x10;
    			break;
    		default:
    			*display3 = 0x7F;
    			break;
    	}

    	while(*switch1 != 0x00){
        	if(*rst == 0x01) number = 0;
        }
	}
}
