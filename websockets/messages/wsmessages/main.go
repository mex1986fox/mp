package wsmessages

import (
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

func GetUnreadMessage(userID int) map[int]int {
	//массив (карта) соединений
	//ключом является id юзера
	// userID := 5
	// открываем соединение
	session, err := mgo.Dial("mongodb://127.0.0.1:27017")
	if err != nil {
		panic(err)
	}
	defer session.Close()

	// получаем коллекцию диалогов
	type Dialog struct {
		ApponentID int    `bson:"apponent_id"`
		DialogID   string `bson:"dialog_id"`
	}
	type Dialogs struct {
		Dialogs Dialog `bson:"dialogs"`
		ID      int    `bson:"_id"`
	}
	dialogsCollection := session.DB("messages").C("dialogs")
	pipeline := []bson.M{
		bson.M{"$match": bson.M{"_id": userID}},
		bson.M{"$unwind": "$dialogs"},
	}
	pipe := dialogsCollection.Pipe(pipeline)
	resp := []Dialogs{}
	err = pipe.All(&resp)
	// fmt.Println(resp)
	dialogsID := []string{}
	for i := 0; i < len(resp); i++ {
		dialogsID = append(dialogsID, string(resp[i].Dialogs.DialogID))
	}
	// fmt.Println(dialogsID)
	// // получаем коллекцию новых сообщений
	type message struct {
		UserID      int  `bson:"user_id"`
		StatusReade bool `bson:"status_read"`
	}

	//карта новых сообщений
	unreadMessage := make(map[int]int)

	for i := 0; i < len(dialogsID); i++ {
		massegesCollection := session.DB("messages").C(dialogsID[i])
		respM := []message{}
		err = massegesCollection.Find(bson.M{"status_read": false}).All(&respM)

		// составляем карту новых сообщений
		for i := 0; i < len(respM); i++ {
			unreadMessage[respM[i].UserID] = unreadMessage[respM[i].UserID] + 1
		}
	}

	return unreadMessage
	// unreadMessagei[25] = 4
	//для сравнения со старой картой
	// fmt.Println(reflect.DeepEqual(unreadMessage, unreadMessageOLD))
	// если карты не совпадут отправить ее
	// fmt.Println()

}
