package main

import (
	"fmt"

	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

func main() {
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
	dialogsCollection := session.DB("messages").C("dialogs")
	pipeline := []bson.M{
		bson.M{"$match": bson.M{"_id": 7}},
		bson.M{"$unwind": "$dialogs"},
	}
	pipe := dialogsCollection.Pipe(pipeline)
	resp := []bson.M{}
	err = pipe.All(&resp)
	fmt.Println(resp)
	dialogsID := []string{}
	for i := 0; i < len(resp); i++ {
		dia := resp[i]["dialogs"]
		// dia.(map[string]interface{})
		fmt.Println(dia)
		// fmt.Printf("%+v\n", dia)
		// dialogsID = append(dialogsID, string(resp[i]["dialogs"]["dialog_id"]))
	}
	fmt.Println(dialogsID)

	// // получаем коллекцию новых сообщений
	// massegesCollection := session.DB("messages").C("messages")
	// pipelineM := []bson.M{
	// 	bson.M{"$match": bson.M{"_id": bson.M{"$in": dialogsID}}},
	// 	bson.M{"$unwind": "$dialogs"},
	// }
	// pipe := massegesCollection.Pipe(pipelineM)
	// resp := []bson.M{}
	// err = pipe.All(&resp)
	// dialogs := resp[0]["dialogs"]

}
