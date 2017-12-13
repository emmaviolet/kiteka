# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = Question.create([
	{ text: "Is this a real account?" },
	{ text: "Are they Female?" },
	{ text: "Are they Male?" },
	{ text: "Are they under 13?" },
	{ text: "Are they between 13-25?" },
	{ text: "Are they aged between 25-45? " },
	{ text: "Are they over 45?" },
	{ text: "Are they based in Europe?" },
	{ text: "Are they based in America?" },
	{ text: "Are they based in Asia?" },
	{ text: "Are they based in Africa?" },
	{ text: "Are they based in a city?" },
	{ text: "Do they like fashion?" },
	{ text: "Do they like art?" },
	{ text: "Do they like food?" },
	{ text: "Do they like music?" },
	{ text: "Do they like nature?" },
	{ text: "Do they like holidays?" },
	{ text: "Do they like family?" },
	{ text: "Do they like parties?" }
])

images = Image.create([
	{ path: "https://timedotcom.files.wordpress.com/2017/07/cow-army.jpg" },
	{ path: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Hausziege_04.jpg/1200px-Hausziege_04.jpg" },
	{ path: "https://www.cats.org.uk/uploads/images/featurebox_sidebar_kids/grief-and-loss.jpg" },
])

allowed_users = AllowedUser.create([
	{ email: "lubowarashidah1@gmail.com" },
	{ email: "nambafusalamah590@gmail.com" },
	{ email: "nankyajustine77@gmail.com" },
	{ email: "arianemugisa@gmail.com" },
	{ email: "helenekansime56@gmail.com" },
	{ email: "evealexander@gmail.com" },
	{ email: "nakilyowadamali@gmail.com" },
	{ email: "odettefuraha8@gmail.com" },
	{ email: "caroarek@gmail.com" },
	{ email: "viviankansiime@gmail.com" },
	{ email: "hephzi@kiteka.com" },
	{ email: "nitishah@kiteka.com" },
	{ email: "bethy@kiteka.com" },
])
