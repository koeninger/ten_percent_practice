import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const factory = new web3.eth.Contract(
	JSON.parse(CampaignFactory.interface),
	'0xb7195D665078FfcD839Fc5A0B19d8a4B95Cf6C94'
	// '0x98E0A3dFdf02AcDf6D03F23090a2e8Baba8f97de'
);

export default factory;