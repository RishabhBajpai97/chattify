package models
type User struct{
FirstName string `json:"firstname"`
LastName string `json:"lastname"`
Username string	`json:"username"`
Password string `json:"password"`
}
type LoginRequest struct{
	Username string `json:"username"`
	Password string `json:"password"`
}