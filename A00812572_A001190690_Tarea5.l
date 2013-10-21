  
        int i, indents = 0;
	char list = 'f';   

%s indenTo
%s textBef

%%

<INITIAL>\n     for(i=0; i<indents; i++) printf("    ");
\n              BEGIN textBef;
<textBef>\<     {
                   BEGIN 0;
                   printf("\n");
                    for(i=0; i<indents; i++) 
                        printf("    ");
                    indents++; printf("<");
                }
\<              indents++; printf("<"); BEGIN 0;
\<!             printf("<!"); BEGIN 0;
\<meta          printf("<meta"); BEGIN 0;
\<li		{
			if(list=='f') indents++; 
			if(list=='t'){
				printf("\n");
				for(i=0; i<indents-1; i++) printf("    ");
			}
			printf("<li"); list='t'; BEGIN 0;
		}
\>              {
                    BEGIN indenTo;
                    printf(">\n");
                    for(i=0; i<indents; i++)
                        printf("    ");
                }

\<\/            {
                    BEGIN 0;
                    --indents;
                   printf("\n");
                    for(i=0; i<indents; i++) printf("    ");   
                    printf("</");
                }
\<\/li		{
			BEGIN 0;
			--indents;
			printf("\n");
			for(i=0; i<indents; i++) printf("    ");
			list='f';
			printf("</li");
		}
\<strong\>|\<EM\>|\<\/strong\>|\<\/EM\>             printf("%s",yytext);
.               BEGIN textBef; printf("%s",yytext);

%%


 int   main()
        {
            yylex();
        }  