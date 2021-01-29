const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { usuarioConectado, usuarioDesconectado } = require('../controllers/socket');
const { getUsuarios } = require('../controllers/usuarios');


//function refresh(client = SocketIO.Socket){
//    client.broadcast.emit('refresh');
//    console.log('me retrase 1 segundo');
//}
// Mensajes de Sockets
io.on('connection', client => {
    
    const [ valido, uid ] = comprobarJWT(client.handshake.headers['x-token']);

    //verificar autenticación
    if (!valido) {
       return client.disconnect();
    }
    //cliente autenticado
    console.log(client.handshake.headers['useremail'], ' CONECTADO: '+valido);
    usuarioConectado(uid);
    
    client.on('userConnected',(payload)=>{
    console.log(payload);
    
        client.broadcast.emit('refresh');// TODO: emitir 1/2 segundo despues
        
    
    //client.broadcast.emit('refresh');
    //setTimeout(refresh(client),2000);
    //client.emit('refresh');
    
    });
    
    // ingresar al usuario a una sala en particular 
    // sala globlal, client.id, id de usuarioMongo
    //client.join( uid );


    client.on('disconnect', () => {
        console.log('Cliente desconectado');
        usuarioDesconectado(uid);
        client.broadcast.emit('refresh');
    });

    

    //client.on('mensaje', ( payload ) => {
    //    console.log('Mensaje', payload);
//
    //    io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
//
    //});


});
    