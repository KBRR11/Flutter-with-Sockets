const { io } = require('../index');

const Bands = require('../models/bands');
const Band = require('../models/band');

const bands = new Bands();
console.log('------------------ INIT SERVER ------------------');
bands.addBand(new Band('Queens'));
bands.addBand(new Band('ACDC'));
bands.addBand(new Band('Nirvana'));
bands.addBand(new Band('Simple Plan'));
//console.log(bands);

// Mensajes de Sockets
io.on('connection', client => {
    console.log('cliente Conectado');

    client.emit('active-bands', bands.getBands() );

    client.on('disconnect', () => { 
        console.log('cliente Desconectado');
    });

    client.on('mensaje',(payload)=> {

        console.log('mensaje:' , payload );

        io.emit('mensaje' , {admin: 'Nuevo mensaje'});
    }
    );
 /// Votar por una Banda
    client.on('vote-band', (payload) =>{
    // console.log(payload);
     bands.voteBand(payload.id);
     io.emit('active-bands', bands.getBands());
    });
// Agregar una Nueva banda
    client.on('add-band', (payload)=> {
     //console.log(payload);//TODO: BORRAR console
     bands.addBand(new Band(payload.name));
     io.emit('active-bands', bands.getBands());
    });
// Borrar una Banda
    client.on('delete-band', (payload)=>{
    //console.log(payload);//TODO: BORRAR console
    bands.deleteBand(payload.id);
    io.emit('active-bands', bands.getBands());
    });

  });