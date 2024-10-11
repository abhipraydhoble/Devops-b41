# Git Notes

#### Que. Differnence between CVCS and DVCS

#### Git Working
![image](https://github.com/user-attachments/assets/b859c770-3efc-48c4-8d77-34508fc51d22)

#### Git Basic Commands
- To initialize empty git repository
```
git init
```
- Congfigure Username and EmailID
```
git config --global user.email "testemail@gmail.com"
git config --global user.name "abhi"
git config --global --list
```

- create test file
```
touch index.html
```
- Add newly created file to staging area
```
git add index.html
```
- Verify file added to staging area or not
```
git status
```
- Commit file to local repository
```
git commit -m "message"
```
- verify commmit
```
git log
```
- Push using  remote repo
```
git remote add origin https://github.com/abhipraydhoble/Devops-B-fourtyone.git
```
- Verify
```
git remote -v
```
- Note: Make sure to generate github token before pushing to remote
- go to github profile ->settings->developer setting->personal access token-> token classic->generate new
  
![image](https://github.com/user-attachments/assets/2c0ab9dc-5dda-408d-b219-f37f14fcae44)

- copy token to somewhere for future use

- Push to Remote repository
```
git push origin master
```
- it will ask for username and token
