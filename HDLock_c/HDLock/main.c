
#include <windows.h>
#include <stdio.h>

int ReadDisk(int Id, int num, unsigned char *buffer);
int WriteDisk(int Id, int num, unsigned char *buffer);

char *str1="wwefeferfed";
char hexstr[3]={0};

#define cryptFlag 445

/*
hex -- 0~16 之间
*/
unsigned char hex2char(unsigned char hex)
{
	if ( (hex >= 0) && (hex <=9) )
	{
		return hex + '0';
	}

	if ( (hex >= 10) && (hex <=15) )
	{
		return hex + 'A' - 10;
	}

	return 0;
}

void int2char(unsigned char hex, char *ptr)
{
	unsigned char hhex,lhex;
	hhex = hex >> 4;
	lhex = hex - (hhex << 4);
	ptr[0] = hex2char(hhex);
	ptr[1] = hex2char(lhex);
}

void printHex();

//int __stdcall WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
	char keys[256]={0};
	unsigned char lock_disk[512]={0};
	unsigned char mbr[512]={0};
	unsigned char len;
	int i=0;
	byte XResult=0;

	FILE* hFileRec;
	FILE* hFileHex;

	hFileRec = fopen("rec.txt","wb");
	
	fwrite("201512", 6, 1, hFileRec);
	fwrite("\r\n", 2, 1, hFileRec);
	hexstr[2] = ' ';

	hFileHex = fopen("HDLock.bin","rb");
	fread(lock_disk, 512, 1, hFileHex);
		
	for (i=0;i<512;i++)
	{
		if (i % (16) == 0)
		{
			fwrite("\r\n", 2, 1, hFileRec);
		}

		int2char(lock_disk[i],hexstr);
		fwrite(hexstr, 3, 1, hFileRec);
	}

	GetPrivateProfileStringA("Locker","psw","left",keys,256,".\\Config.ini");
	len = strlen(keys);
	if (len == 0 || len >= 18)
	{
		MessageBoxA(NULL, "错误！密码长度建议控制在0-18内", "ERROR", MB_OK | MB_ICONERROR);
		exit(-1);
	}

	fwrite(keys, len, 1, hFileRec);
	//return 0;
	
#if 0
	
	for (i=0;i<len;i++)
	{
		XResult ^= keys[i];
	}

	if (ReadDisk(0,1,mbr) == 0)
	{
		MessageBoxA(NULL, "Read MBR failed!", "ERROR", MB_OK | MB_ICONERROR);
		exit(-1);
	}

	if (mbr[cryptFlag] == 0x16)
	{
		MessageBoxA(NULL, "错误！硬盘已经加锁，请不要重复加锁..", "ERROR", MB_OK | MB_ICONERROR);
		exit(-1);
	}

	mbr[cryptFlag] = 0x16;

	
	for (i=0;i<64;i++)
	{
		mbr[446+i]^=XResult;
	}
	

	WriteDisk(2,1,mbr);

	memcpy(lock_disk + cryptFlag, mbr+ cryptFlag, 67);

	WriteDisk(0,1,lock_disk);
#endif

	/*
	fwrite("\r\nNEWS\r\n",8, 1, hFileRec);

	if (ReadDisk(0,1,mbr) == 0)
	{
		MessageBoxA(NULL, "Read MBR failed!", "ERROR", MB_OK | MB_ICONERROR);
		exit(-1);
	}

	for (i=0;i<512;i++)
	{
		if (i % (16) == 0)
		{
			fwrite("\r\n", 2, 1, hFileRec);
		}

		int2char(mbr[i],hexstr);
		fwrite(hexstr, 3, 1, hFileRec);

		
	}
	//CString tmpStr;
	*/
	
	
	MessageBoxA(NULL, "成功", "Success", MB_OK | MB_ICONINFORMATION);

	fclose(hFileRec);
	fclose(hFileHex);
	return 0;
}

/*
读取扇区
Id  = ID号
num = 读取数量
成功返回读取字节数
*/
int ReadDisk(int Id, int num, unsigned char *buffer)
{
	HANDLE hFile=NULL;
	int offset=0;
	int ReadSize=0;
	DWORD Readed =0;
	offset = Id*512;
	ReadSize = num*512;

	if (buffer == NULL)
	{
		return ReadSize;
	}

	hFile = CreateFileA(
		"\\\\.\\\\physicaldrive0",
		GENERIC_READ,
		FILE_SHARE_READ | FILE_SHARE_WRITE ,  NULL, OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL, NULL
		);

	if (hFile == INVALID_HANDLE_VALUE)
	{
		MessageBoxA(NULL, "不能打开 \\\\.\\\\physicaldrive0....", "Error", MB_OK | MB_ICONERROR);
		return 0;
	}

	SetFilePointer(hFile,offset,0, 0);
	ReadFile(hFile,buffer,ReadSize,&Readed,NULL);
	CloseHandle(hFile);

	return Readed;
}

/*
	写扇区
*/
int WriteDisk(int Id, int num, unsigned char *buffer)
{
	HANDLE hFile=NULL;
	int offset=0;
	int WriteSize=0;
	DWORD Writed =0;
	offset = Id*512;
	WriteSize = num*512;

	if (buffer == NULL)
	{
		return WriteSize;
	}

	/*
	hFile = CreateFileA(
		"\\\\.\\\\physicaldrive0",
		GENERIC_READ,
		FILE_SHARE_READ | FILE_SHARE_WRITE ,  NULL, OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL, NULL
		);
		*/
	hFile = CreateFileA(
		"\\\\.\\\\physicaldrive0",
		1073741824,
		1 ,  0, 3,
		128, 0
		);

	if (hFile == INVALID_HANDLE_VALUE)
	{
		MessageBoxA(NULL, "不能打开 \\\\.\\\\physicaldrive0....", "Error", MB_OK | MB_ICONERROR);
		return 0;
	}

	SetFilePointer(hFile,offset,0, 0);
	WriteFile(hFile,buffer,WriteSize,&Writed,NULL);
	CloseHandle(hFile);

	return Writed;
}