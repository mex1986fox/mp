package main

import (
	"fmt"
	"net/http"

	"github.com/gorilla/websocket"
)

//массив (карта) соединений
//ключом является id юзера
var connects = make(map[string]*websocket.Conn)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func addConnection(response http.ResponseWriter, request *http.Request) {
	// sessionID := request.URL.Query().Get("session_id")
	// userID := request.URL.Query().Get("user_id")
	sessionID := "sm2h4m1t0tlekjbeos7bsc569m"
	userID := "1"
	//  сходить на сервер проверить авторизацию и аутентификацию по номеру сессии
	client := &http.Client{}
	req, err := http.NewRequest(
		"GET", "http://drovito.ru/api/authentication/users?user_id="+userID, nil,
	)
	// добавляем заголовки
	req.Header.Add("Accept", "text/html")
	req.Header.Add("User-Agent", "MSIE/15.0")
	req.Header.Add("Content-Type", "application/json")
	req.Header.Add("Cookie", "PHPSESSID="+sessionID+";")
	resp, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer resp.Body.Close()

	// если статус ответа 200 т.е. пользователь авторизован и аутентифицирован
	// создаем новое подключение к сокету
	if int16(resp.StatusCode) == 200 {
		fmt.Println("USER AUTENTIFICATION")
		connection, err := upgrader.Upgrade(response, request, nil)
		if err != nil {
			fmt.Println(err)
		}
		connects[userID] = connection
		fmt.Println("New connection: ", connects)
	}
	fmt.Println("Запрос закончен")

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
