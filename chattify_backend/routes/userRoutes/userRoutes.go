package routes

import (
	"github.com/RishabhBajpai97/chattify_backend/controllers"
	"github.com/gofiber/fiber/v2"
)

func GetUserRoutes(app *fiber.App){
	app.Get("/", controllers.Index)
	app.Post("/user/signup", controllers.SignUp )
	app.Post("/user/login", controllers.Login )
	app.Post("/user/sendOtp", controllers.SendOtp )
	app.Post("/user/verifyOtp", controllers.VerifyOtp )
}