const graphql = require('graphql');
const axios = require('axios');

const {
	GraphQLObjectType,
	GraphQLInt,
	GraphQLString,
	GraphQLSchema
} = graphql;

const UserType = new GraphQLObjectType({
	name: 'User',
	fields: {
		id: { type: GraphQLString },
		name: { type: GraphQLString },
		age: { type: GraphQLInt }
	}
});

const RootQuery = new GraphQLObjectType({
	name: 'RootQueryType',
	fields: {
		user: {
			type: UserType,
			args: {
				id: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args) {
				const url = `http://10.116.53.33:3004/users/${args.id}`;
				return axios.get(url).then(response => response.data);
			}
		}
	}
});

module.exports = new GraphQLSchema({
	query: RootQuery
});