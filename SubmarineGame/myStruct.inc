include windows.inc
include user32.inc
include kernel32.inc
include gdi32.inc
includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
include msvcrt.inc
includelib msvcrt.lib

BOMB struct
	X dd ? ;����x����
	Y dd ? ;����y����
BOMB ends

TORPEDO struct
	X dd ? ;����x����
	Y dd ? ;����y����
	TIMECOUNT dd ? ;�������ʱ
TORPEDO ends

SUBMARINE struct
	X SDWORD ? ;����x����
	Y dd ? ;����y����
	SPEED dd ? ;�ٶ�
	DIRECTION dd ? ;����0��1��
	CARRYBOMB dd ? ;�Ƿ�Я��ը����0��1��
SUBMARINE ends

EXPLODE struct
	X SDWORD ? ;����x����
	Y dd ? ;����y����
	PIC dd ? ;ͼƬ״̬����1~22�����л�
EXPLODE ends