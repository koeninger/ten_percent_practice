import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const factory = new web3.eth.Contract(
	JSON.parse(CampaignFactory.interface),
	'0x09C983BaB5dA5e67442829E28DC19c3CF595ECBF'
	// '0x51D5B131795cDf813D05C8E9F4dd79F8e049386f'
	// '0xba471c68367fdd02495bA491990548147f666b31'
	// '0x852205846B99310A23f0372A5F9233a079ba07D7'
	// '0xb7195D665078FfcD839Fc5A0B19d8a4B95Cf6C94'
	// '0x98E0A3dFdf02AcDf6D03F23090a2e8Baba8f97de'
);

export default factory;