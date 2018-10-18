package main

import (
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
)

// //массив (карта) соединений
// //ключом является id юзера
// var connects map[string]*websocket.Conn

// //  сходить на сервер забрать id юзера по номеру сессии

// var upgrader = websocket.Upgrader{
// 	ReadBufferSize:  1024,
// 	WriteBufferSize: 1024,
// 	CheckOrigin: func(r *http.Request) bool {
// 		return true
// 	},
// }

func addConnection(response http.ResponseWriter, request *http.Request) {
	// sessionID := request.URL.Query().Get("session_id")
	// userID := request.URL.Query().Get("user_id")
	//  сходить на сервер забрать id юзера по номеру сессии
	fmt.Println("Начали запрос на http://drovito.ru/api/authentication для авторизации ...")
	//подготавливаем запрос
	httpRequest := "GET/HTTP/1.1\n" +
		"Host: golang.org\n\n" +
		"Content-Type: application/json\n\n" +
		"Cookie: PHPSESSID=0dhr76vie4b8t51989efp1gt13; user_id=1\n\n"
	// отправляем пакет
	conn, err := net.Dial("tcp", "drovito.ru/api/authentication/users")
	if err != nil {
		fmt.Println(err)
	}

	if _, err = conn.Write([]byte(httpRequest)); err != nil {
		fmt.Println(err)
	}
	//читаем ответ
	io.Copy(os.Stdout, conn)
	conn.Close()
	fmt.Println("Запрос закончен")

	// connection, err := upgrader.Upgrade(response, request, nil)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// connects[string(sessionID)] = connection

	// fmt.Println("New connection: ", connection)
	// for {
	// 	conn := connect.conn
	// 	messageType, message, err := conn.ReadMessage()
	// 	if err != nil {
	// 		fmt.Println(err)
	// 		return
	// 	}
	// 	if message != nil {
	// 		fmt.Println(messageType)
	// 		fmt.Println(string(message))
	// 	}

	// 	interval.Start(func() {
	// 		if err := conn.WriteMessage(1, []byte("Gudby")); err != nil {
	// 			fmt.Println(err)
	// 			return
	// 		}
	// 	}, 5*time.Second)

	// }
}
func handler(response http.ResponseWriter, request *http.Request) {
	addConnection(response, request)

}

func main() {
	// запрос такого плана /ws?user_id=1?session_id=dfdfg23d
	http.HandleFunc("/ws", handler)
	fmt.Println("Server started ...")
	err := http.ListenAndServe(":8085", nil)
	if err != nil {
		fmt.Println("ListenAndServer: ", err)
	}

}
