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
			term: 'vsauce'
		}, (videos) => {
			this.setState({ videos });
		});
	}

	render() { 
		return (
			<div className="row">
				<div className="col-lg mt-3">
					<SearchBar />
					<VideoDetail video={this.state.videos[0]} />
				</div>
				<div className="col-lg-3 mt-3">
					<VideoList videos={this.state.videos} />
				</div>
			</div>
		);
	}
}

ReactDOM.render(<App />, document.querySelector('.container'));