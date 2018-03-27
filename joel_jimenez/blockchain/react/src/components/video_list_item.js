import React from 'react';

const VideoListItem = ({video}) => {
	const imageUrl = video.snippet.thumbnails.default.url;
	const videoTitle = video.snippet.title;

	return (
		<li>
			<div className="card">
				<figure className="media-left">
					<p className="image">
						<img src={imageUrl} />
					</p>
				</figure>
				<div className="media-content">
					<p>{videoTitle}</p>
				</div>
			</div>
		</li>
	);
};

export default VideoListItem;