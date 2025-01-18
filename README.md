# projeto_firebase

Um projeto flutter feito para praticar ferramentas do firebase. Baseado no canal do Deivid Willyan.
Hoje tem o flutterfire, então a configuração fica mais fácil. Porém, aqui fica um guia para não depender dele e saber quando algo der ruim.

<details><summary><h2>1. Configurando</h2></summary>

Crie um projeto no firebase e então adicione os aplicativos android e iOS.
iOS fica configurado, porém o android pode faltar algumas configurações, como versão mínima de sdk e etc.
A princípio, se configurar errado, sequer vai buildar o app.

</details>


<details><summary><h2>2. Push Notifications</h2></summary>

Eu primeiro crio uma configuração local em custom_local_notification, e no custom_firebase_messaging eu
configuro para se comunicar com o firebase. 

Não se aplica a iOS, pois para isto precisa-se de um certificado de desenvolvedor

</details>

<details><summary><h2>3. Remote Config</h2></summary>

Talvez a parte mais simples. Remote config são basicamente variáveis passadas pelo firebase, para que o aplicativo pegue e use-o.
No arquivo remote_config tem a periodicidade que o aplicativo vai buscar informação no firebase, e o método getValueOrDefault, 
que pega o chave-valor da cache.

</details>

<details><summary><h2>4. lab Remote + push</h2></summary>

Um laboratório demonstrando que, por exemplo, eu consigo forçar fetch por notificação. 
P.s: perceba que alterando o valor de "isActiveBlue" não necessariamente muda a cor na hora, somente ao reiniciar o app.

</details>

<details><summary><h2>5. crashlytics</h2></summary>

Ok, eu disse no 3 que ele era o mais simples... Estava enganado.
Firebase crashlytics é uma forma de você ver visualmente os crashs que o aplicativo do seu usuário teve.
Para usar não é tão difícil. Basta reportar sempre que ocorrer um erro. Dentro de um try catch já resolve.

</details>