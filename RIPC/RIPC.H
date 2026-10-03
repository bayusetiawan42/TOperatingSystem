#ifndef _RIPC_H
#define _RIPC_H

#include <stdio.h>
#include <stdlib.h>

//
//Lexer.C
//

typedef enum
{
	TOK_IDENT,			//Identifier
	TOK_NUM,			//NUMERIC
	TOK_OP,				//OPERATOR
} TokenKind;

typedef struct
{
	char* name;
	const char* content; //MMAPed
	FILE* ptr;
} File;

typedef struct Token    Token;
struct Token
{
	TokenKind kind;
	Token *next;
	char* start;
	int len;

	File *file;
};

//
//Errors.C
//

void die(const char* fmt, ...);

#endif //_RIPC_H
