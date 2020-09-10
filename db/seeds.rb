User.destroy_all
Event.destroy_all
Appointment.destroy_all

User.create(name: "ZHENGJIAN LIU", phone: 1234, age:22, occupation: "programmer", password: 1234)
Event.create(name: "this", category: "event", location: "here", date: "07/18/2020", time: "8:00pm", description: "an event to add")