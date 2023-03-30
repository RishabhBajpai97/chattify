package controllers

import (
	"fmt"
	"log"
	"sync"
	"time"

	"github.com/gofiber/websocket/v2"
)

var messageChan = make(chan string)
var clients = Clients{}

type WsReponse struct {
	Username string `json:"username"`
	Content  string `json:"content"`
}
type Clients struct {
	sync.Mutex
	Connections []Connection
}

type Connection struct {
	Conn     *websocket.Conn
	UserData User
}
type User struct {
	Username string `json:"username"`
	UserId   string `json:"userid"`
}

type Message struct{
	SenderId string
	ReceiverId string
	Timestamp time.Time
	Content string
}

func WsEndpoint(c *websocket.Conn) {
	//when user connects it sends userid and username to register
	var user User
	var userConnected bool = false
	err := c.ReadJSON(&user)
	fmt.Println(user)
	//looping over connections to check whether user exists or not
	for _, connection := range clients.Connections {
		fmt.Println(connection.UserData.Username)
		if user.Username == connection.UserData.Username {
			userConnected = true
			break
		}
	}
	//to check if user is already connected or not, we dont want to connect over and over to the same user with different connection
	if !userConnected {

		clients.Connections = append(clients.Connections, Connection{Conn: c, UserData: user})
	}
	fmt.Println(clients.Connections)
	var reponse WsReponse
	reponse.Username = "rishbh"
	reponse.Content = "hey there"
	err = c.WriteJSON(reponse)
	if err != nil {
		log.Println(err)
	}
	listenForWs(c)
}

func broadCast(response WsReponse) {
	log.Println(response.Username)
	for _, client := range clients.Connections {
		client.Conn.WriteJSON(response)
		// log.Println(client)
	}
}

func listenForWs(c *websocket.Conn) {
	var payload WsReponse
	for {
		err := c.ReadJSON(&payload)
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
				log.Printf("error: %v", err)
			}
			break
		}
		log.Println(payload)
		if err != nil {
			log.Println(err)

		}
		broadCast(payload)
	}
}
