マスターにいるかの確認
git branch
マスターにいたらそのままブランチを追加する
いなければ
git checkout master で移動
ブランチ追加
git checkout -b 新しいブランチ名
Gitを追加
git add .
Gitをコミット
git commit -m "変更した内容"
git push  origin ブランチ名


最新のを持ってくるコマンド
git pull origin master

これもマスターにいる確認した後でやるいなければcheckout でブランチをmaster切り替えてから行う

絶対ブランチは切る

番外編

変更したファイルの確認
git status

変更したコードの確認
git diff
