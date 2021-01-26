const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');


// Mensajes de Sockets
io.on('connection', client => {
    
    const [ valido, uid ] = comprobarJWT(client.handshake.headers['x-token']);
    if (!valido) {
       return client.disconnect();
    }
    console.log(client.handshake.headers['useremail'], ' CONECTADO: '+valido);
    

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });

    

    //client.on('mensaje', ( payload ) => {
    //    console.log('Mensaje', payload);
//
    //    io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
//
    //});


});
    