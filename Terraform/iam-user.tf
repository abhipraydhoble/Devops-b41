resource "aws_iam_user" "user1" {
    name = "natasha"
}

resource "aws_iam_user" "user2" {
    name = "bruce"
}

resource "aws_iam_user" "user3" {
    name = "steve"
}

resource "aws_iam_user" "user4" {
    name = "clint"
}

resource "aws_iam_user" "user5" {
    name = "tony"
}

resource "aws_iam_user" "user6" {
    name = "thor"
}


resource "aws_iam_group" "team" {
    name = "Avengers"
}

resource "aws_iam_group_membership" "add" {
  name = "teamup"

  users = [
    aws_iam_user.user1.name,
    aws_iam_user.user2.name,
    aws_iam_user.user3.name,
    aws_iam_user.user4.name,
    aws_iam_user.user5.name,
    aws_iam_user.user6.name
  ]

  group = aws_iam_group.team.name
}
