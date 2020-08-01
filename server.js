const express = require('express');
const passport = require('passport');
const bodyParser = require('body-parser');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const cors = require('cors');

const config = require('./config');

const app = express();

const userRouter = require('./routes/user');
const jobRouter = require('./routes/job');
const applicantRouter = require('./routes/applicant');
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');

/* Middleware */
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
  secret: config.sessionSecret,
  resave: true,
  saveUninitialized: true,
}));
app.use(cookieParser(config.sessionSecret));
app.use(passport.initialize());
app.use(passport.session());
require('./utils/passport')(passport);

app.use(cors());

/* Routes */
app.use('/', authRouter);
app.use('/', userRouter);
app.use('/', jobRouter);
app.use('/', applicantRouter);
app.use('/', adminRouter);

const port = process.env.PORT || 5000;

app.listen(port, () => console.log(`Server started on port ${port}`));
