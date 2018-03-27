import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import YoutubeSearch from 'youtube-api-search';

import SearchBar from './components/search_bar';
import VideoList from './components/video_list';
import VideoDetail from './components/video_detail';
import APP_KEY from './components/youtube_api_key';

class App extends Component {
	constructor(props) {
		super(props);
		this.state = { videos: [] };

		YoutubeSearch({
			key: APP_KEY,
			term: 'mean cats'
		}, (videos) => {
			this.setState({ videos });
		});
	}

	render() { 
		return (
			<div className="columns">
				<div className="column">
					<SearchBar />
					<VideoDetail video={this.state.videos[0]} />
				</div>
				<div className="column is-one-third">
					<VideoList videos={this.state.videos} />
				</div>
			</div>
		);
	}
}

ReactDOM.render(<App />, document.querySelector('.container'));