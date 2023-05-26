import Vapor


var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)

defer { app.shutdown() }
app.get { req in "Hello World!" }
try app.run()
