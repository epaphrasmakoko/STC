# You need to git clone the project to you prefered directory then,

# frontend
# First you need to install NODE.JS and NPM latest
# Second you need to install vue3 for the project perspective 

## Third Project setup
```
npm install
```
### fourth Compiles and hot-reloads for development
```
npm run serve
```
## The frontend will work then since it's a blockchain project
### you need to deploy the contract named **mainAccount.sol**
### use **remix IDE** to compile and deploy the contract to the blockchain network

### step 5: download and install ganache gui 

### step 6: install and connect metamask to the ganache gui (you can search google on how to do this).
### but apparently you need to add a custom test network and use the network like this in RPC field  eg, RPC url (HTTP://127.0.0.1:7545) chain ID usually **1337**
### then you need to add the accounts to metamask... Go ganache GUI and find the account in acoounts Tab then then click on key icon then copy the private key 
### then open metamask in browser eg firefox then add acoount then choose import account then paste the private key. done you just added an account 
### and this first account will be named as **Admin**

### step 7: open remix IDE and upload the contract named **mainAccount.sol** then go to the compile tab and choose **0.8.0+commit.c7dfd78e** unless you wont be able to deploy to ganache
### then next deploy the contract to ganache by clickiing on deploy tab on the left, then on **Environment** field choose **injected provider metamask**
### then pop up of metamask will appear wanting to connect to account available,then choose the **ADMIN** ACCOUNT  you previous added, then connect
### then now click on deploy button, then confirm the transaction. youhave just deployed the contract **mainAccount.sol**


### step 9: open the source code in **visual studio code** then find these two components a. dashboard.vue and b. app.vue
### edit this part of line by reference is this line **(const contractAddress = '0xEC8548075D7543722bc451DDf1dbd498EDed7D56'; // contract address)**
### and put the address of the contract you deployed ( find it ganache gui then transactions tab, go down to the first transaction you will find the transaction called **contract creation**
### then click on it you will find this field example (**CREATED CONTRACT ADDRESS 0xEC8548075D7543722bc451DDf1dbd498EDed7D56** ) then copy the address **0xEC8548075D7543722bc451DDf1dbd498EDed7D56**
### the paste it on this line **(const contractAddress = '0xEC8548075D7543722bc451DDf1dbd498EDed7D56'; // contract address)** it will be (const contractAddress = '0xEC8548075D7543722bc451DDf1dbd498EDed7D56'; // contract address)
### paste the contract address to this component dashboard.vue and this component app.vue

### after pasting all is good now just add other user to the metamask the userswitch to admin to add user like CEO and other normal users 
### note: only ONE CEO for now.










### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
