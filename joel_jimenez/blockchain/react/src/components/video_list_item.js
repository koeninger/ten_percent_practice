import React from 'react';

const VideoListItem = ({video, onVideoSelect}) => {
	const imageUrl = video.snippet.thumbnails.default.url;
	const videoTitle = video.snippet.title;
	const videoDescription = video.snippet.description;

	return (
		<li className="list-group-item video-list-item" onClick={() => {onVideoSelect(video)}}>
			<div className="media">
				<img className="mr-3" src={imageUrl} />
				<div className="media-body">
					<p className="mt-0 ">{videoTitle}</p>
				</div>
			</div>
		</li>
	);
};

export default VideoListItem;