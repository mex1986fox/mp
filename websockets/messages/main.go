package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"time"

	"./wsmessages"

	"github.com/aubm/interval"
	"github.com/gorilla/websocket"
)

// структура подключения
type connect struct {
	Socket    *websocket.Conn
	UserID    string
	SessionID string
	SendData  bool
}

//структура для передачи данных по сокету json
//параметры для функции

// карта подключений ключ состоит из номера юзера и номера сессии
// пример 1212+45jndfdf
var connects = make(map[string]*connect)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func addConnection(response http.ResponseWriter, request *http.Request) {
	sessionID := request.URL.Query().Get("session_id")
	userID := request.URL.Query().Get("user_id")
	conKey := string(userID) + string(sessionID)
	fmt.Println(connects)
	// if connects[conKey] != nil {
	// 	go socketHandler(connects[conKey])
	// 	fmt.Println("OLD connection ...")
	// } else {

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
		// и если для данного юзера не создано подключение к соккету
		// создаем новое подключение к сокету

		if int16(resp.StatusCode) == 200 {
			fmt.Println("USER AUTENTIFICATION")
			connection, err := upgrader.Upgrade(response, request, nil)
			if err != nil {
				fmt.Println(err)
			}
			// помещаем подключение к сокету в коллекцию

			connects[conKey] = &connect{
				UserID:    userID,
				SessionID: sessionID,
				Socket:    connection,
			}
			go socketHandler(connects[conKey])
			fmt.Println("New connection ...")
		// }
	}
	fmt.Println("Запрос закончен")

}
func handler(response http.ResponseWriter, request *http.Request) {
	addConnection(response, request)
}
func socketHandler(connect *connect) {

	sock := connect.Socket
	usId, _ := strconv.ParseInt(connect.UserID, 10, 64)

	for {
		interval.Start(func() {
			if connect.SendData == true {
				newMap := wsmessages.GetUnreadMessage(int(usId))
				//отправляем маску
				if err := sock.WriteJSON(newMap); err != nil {
					fmt.Println(err)
				}
				connect.SendData = false
			}
		}, 3*time.Second)

		type method struct {
			Name   string `json:"name"`
			Params []struct {
				Name string `json:"name"`
				Val  string `json:"val"`
			} `json:"params"`
		}
		meth := method{}

		_, body, err := sock.ReadMessage()
		if err != nil {
			fmt.Println(err)
			conKey := string(connect.UserID) + string(connect.SessionID)
			delete(connects, conKey)
			return
		}
		json.Unmarshal(body, &meth)
		fmt.Println(meth.Name)
		if meth.Name == "GetUnreadMessages" {
			newMap := wsmessages.GetUnreadMessage(int(usId))
			//отправляем маску
			if err := sock.WriteJSON(newMap); err != nil {
				fmt.Println(err)
			}
		}
		if meth.Name == "SetUnreadMessage" {
			for _, par := range meth.Params {
				if par.Name == "apponentID" {
					for i, conn := range connects {
						if conn.UserID == string(par.Val) {
							connects[i].SendData = true
						}
					}
				}
			}

		}

	}
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
