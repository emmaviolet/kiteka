# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = Question.create([
	{ text: "This is the first question?" },
	{ text: "Am I even a question?" },
	{ text: "What even is a question?" },
])

images = Image.create([
	{ path: "https://timedotcom.files.wordpress.com/2017/07/cow-army.jpg" },
	{ path: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Hausziege_04.jpg/1200px-Hausziege_04.jpg" },
	{ path: "https://www.cats.org.uk/uploads/images/featurebox_sidebar_kids/grief-and-loss.jpg" },
])
