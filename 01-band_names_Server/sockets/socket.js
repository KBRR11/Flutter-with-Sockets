const { io } = require('../index');

// Mensajes de Sockets
io.on('connection', client => {
    console.log('cliente Conectado');

    client.on('disconnect', () => { 
        console.log('cliente Desconectado');
    });

    client.on('mensaje',(payload)=> {

        console.log('mensaje:' , payload );

        io.emit('mensaje' , {admin: 'Nuevo mensaje'});
    }
    );
  });