import _ from 'lodash';
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

		this.state = {
			videos: [],
			selectedVideo: null
		};

		this.videoSearch('surfboards');
	}

	videoSearch(searchTerm){
		YoutubeSearch({
			key: APP_KEY,
			term: searchTerm
		}, (videos) => {
			this.setState({
				videos: videos,
				selectedVideo: videos[0]
			});
		});
	}

	render() {
		const videoSearch = _.debounce( (searchTerm) => {
			this.videoSearch(searchTerm)
		}, 300);

		return (
			<div className="row">
				<div className="col-md mt-3">
					<SearchBar onSearchTermChange={videoSearch} />
					<VideoDetail video={this.state.selectedVideo} />
				</div>
				<div className="col-md-4 mt-3">
					<VideoList
						videos={this.state.videos}
						onVideoSelect={selectedVideo => this.setState({selectedVideo})} />
				</div>
			</div>
		);
	}
}

ReactDOM.render(<App />, document.querySelector('.container'));