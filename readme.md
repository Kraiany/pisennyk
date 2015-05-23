Пісенник - українські пісні в зручному для мобільного читання.

# Як опублікувати сторінку

Для опублікування сторінки її потрібно "побудувати" і заслати на Github. Це робиться такими  командами:


Перейти в директорію проекту. І потім:

    git clone -b gh-pages git@github.com:Kraiany/pisennyk.git build
    middelaman build
    cd build
    git add  -A
    git chechout
      [додати коментар до коміту]
    git push origin gh-pages
