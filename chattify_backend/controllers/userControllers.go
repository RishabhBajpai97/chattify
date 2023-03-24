package controllers
import (
	"github.com/gofiber/fiber/v2"
	"fmt"
	"github.com/RishabhBajpai97/chattify_backend/models/user"
   openapi "github.com/twilio/twilio-go/rest/verify/v2"
   "github.com/twilio/twilio-go"
)

var TWILIO_ACCOUNT_SID string = "ACa4e4cca0b3fd9737f9a795857744d922"
var TWILIO_AUTH_TOKEN string = "193d84beda02fe61195f604d14f26380"
var VERIFY_SERVICE_SID string = "VA5b3f2d7bca2e73af29fc3cc90c5c458e"
var client *twilio.RestClient = twilio.NewRestClientWithParams(
   twilio.ClientParams{
   Username: TWILIO_ACCOUNT_SID,
   Password: TWILIO_AUTH_TOKEN,
})

func SignUp(c *fiber.Ctx) error {
	var user models.User
	c.BodyParser(&user)
	fmt.Println(user)
	return c.JSON(&user)
}
func Login(c *fiber.Ctx) error  {
	var body models.LoginRequest
	c.BodyParser(&body)
	fmt.Println(body)
	return c.Status(200).JSON("hello")
}
func Index(c *fiber.Ctx) error {
	return c.Status(200).JSON(map[string]string{
		"message":"Hello",
	})
}
func SendOtp(c *fiber.Ctx) error  {
	var body map[string]string;
	c.BodyParser(&body)
	fmt.Println(body["mobile"])
	params := &openapi.CreateVerificationParams{}
	params.SetTo(body["mobile"])
	params.SetChannel("sms")
	_,err:= client.VerifyV2.CreateVerification(VERIFY_SERVICE_SID,params)
	if err!=nil{
		fmt.Println(err.Error())
	}
	fmt.Println(body)
	return c.Status(200).JSON(body)
}
func VerifyOtp(c *fiber.Ctx) error  {
	var body map[string]string;
	c.BodyParser(&body)
	params:= &openapi.CreateVerificationCheckParams{}
	params.SetTo(body["mobile"])
	params.SetCode(body["code"])
	result, err:= client.VerifyV2.CreateVerificationCheck(VERIFY_SERVICE_SID,params)
	if err!=nil{
		fmt.Println(err.Error())
		return nil
	} else if *result.Status == "approved"{
		return c.Status(200).JSON(map[string]string{
			"message":"success",
		})
	} else {
		return c.Status(403).JSON(map[string]string{
			"message":"failed",
		})
	}
}
