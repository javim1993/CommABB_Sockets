MODULE Module1
VAR socketdev server_socket;
VAR socketdev client_socket;
VAR string client_ip;
VAR string receive_string;
	CONST robtarget p10:=[[514.87,-110.47,411.07],[0.445122,0.0179534,0.895155,-0.015567],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p20:=[[537.09,134.35,411.05],[0.445097,0.0179447,0.895165,-0.0156757],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
PROC main()

SocketClose server_socket; !Cierra los dos por si acaso están abiertos (tanto servidor como cliente)
SocketClose client_socket;
SocketCreate server_socket; !En el servidor cremos el socket (crear el puerto o abrir el puerto)
SocketBind server_socket, "192.168.125.1", 1025; !le damos la dirección y el puerto que queremos abrir
SocketListen server_socket; !Escucho el puerto del servidor
SocketAccept server_socket, client_socket\ClientAddress:=client_ip; !Acepto lo que me manda


SocketSend client_socket \Str := "Hello client with ip-address "+client_ip; !Envio dato al cliente para que sepa que estoy conectado (recojo la IP del cliente)
SocketReceive client_socket \Str := receive_string; !desde el cliente confirmo al servidor
WaitUntil receive_string<>"0"; !espero un dato concreto desde el cliente
IF receive_string="1\0D\0A" THEN 
MoveJ p20, v1000, z50, tool0;
MoveJ p10, v1000, z50, tool0;
ELSE 
    WaitTime 3;
ENDIF

ENDPROC

ENDMODULE
