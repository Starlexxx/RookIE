# RookIE

Web-application for creating interactive chess courses. Create course with only one pgn file and app will devide it into games, which you can use in different chapters. Upload videos to explain game plan and tactic tricks.

## Requirements:

- **Ruby** 3.0.1
- **Rails** 7.0.4
- **MySQL** 8.0.32+

## Running Locally

Make sure you have all the requirments installed.

```sh
git clone git@github.com:Starlexxx/RookIE.git # or clone your own fork
cd RookIE
bundle install
rails db:create:migrate
rails s
```

Your app should now be running on [localhost:3000](http://localhost:3000/).

## TODO
* Black figures logic
* Moderator page for approving courses content
* Tactic lessons
