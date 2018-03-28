import React from 'react';

const VideoDetail = ({video}) => {
	if (!video){
		return (
			<div className="text-center">
				<h2>Loading...</h2>
			</div>
		);
	}
	const videoTitle = video.snippet.title;
	const videoDescription = video.snippet.description;
	const videoUrl = `https://www.youtube.com/embed/${video.id.videoId}`;

	return (
		<div className="card">
			<div className="embed-responsive embed-responsive-16by9">
				<iframe className="embed-responsive-item" src={videoUrl}></iframe>
			</div>
			<div className="card-body">
				<h4 className="card-title">{videoTitle}</h4>
				<p className="card-text">{videoDescription}</p>
			</div>
		</div>
	);
};

export default VideoDetail;